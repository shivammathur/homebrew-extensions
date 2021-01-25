# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT71 < AbstractPhp71Extension
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
    sha256 "6608fc17a24f0990b244096f8f39f62b51b3996f7eb3409bfe77c0edceaaf668" => :big_sur
    sha256 "b6fe9f2881fe75d89521aff2ce633b5ce3775eaad65e011c17531059d90de796" => :arm64_big_sur
    sha256 "08a4ce99edb88feefe0e2e8f7046ba89ae1f8138a6391ca7cd98d74a2e107c6a" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
