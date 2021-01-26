# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhp81Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.6.tar.gz"
  sha256 "3be3b8af91c43db70c4893dd2552c9ee2877e9cf32f59a607846c9ceb64a173b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    rebuild 23
    sha256 "5bc397e1f8f1f62fa0495fe447501ce1c1d5ceb686942c27884399997df16bfc" => :big_sur
    sha256 "85bf21595ead9fb117338e6f706baf180104436dfc7dc5213bb63b7aa0cd0671" => :arm64_big_sur
    sha256 "370653f1da6d2db6317b47a72cc70202782327b2ee91af0ae8f9bc8345ab015a" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
