class HomeController < ApplicationController
  def index
    ic = Iconv.new("utf-8//translit//IGNORE","big5")
    @img = []
    @items = []
    @childs = []
    i=1
    x=1
    while i<20
      doc = Nokogiri::HTML(ic.iconv(open("http://www.missingkids.org.tw/chinese/focus.php?mode=show&id=#{i}&temp=0").read))
      
      doc.search('td>img').each do |img|
        if img['width']=='135'
          @childs << { 'id' => i, 'img' => img['src'] }
          @img << img
          item = []
          doc.css('table[width="100%"]')[0].search('tr>td').each{|row| item << "#{row.content.strip}," }
          @items << item.split(',')
          @childs.select{|item|item["id"] == i}[0]['name'] = @items[x-1][0][1]
          @childs.select{|item|item["id"] == i}[0]['sex'] = @items[x-1][0][3]
          @childs.select{|item|item["id"] == i}[0]['ago'] = @items[x-1][0][5]
          @childs.select{|item|item["id"] == i}[0]['lost_ago'] = @items[x-1][0][7]
          @childs.select{|item|item["id"] == i}[0]['lost_time'] = @items[x-1][0][9]
          @childs.select{|item|item["id"] == i}[0]['feature'] = @items[x-1][0][11]
          @childs.select{|item|item["id"] == i}[0]['lost_area'] = @items[x-1][0][13]
          @childs.select{|item|item["id"] == i}[0]['lost_place'] = @items[x-1][0][15]
          @childs.select{|item|item["id"] == i}[0]['lost_reasons'] = @items[x-1][0][17]
          x= x+1
        end
      end
      i= i+1
    end
  end


end
