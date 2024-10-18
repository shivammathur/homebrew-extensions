# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.7.tgz"
  sha256 "3736aab69aea238dc80fbb385fcb2a878a78fa9460551cf633e119f3854086ef"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b80e19e76227e3f4a3e47ee78f4d733cbe28017856b4647c82e92624eba3f894"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bfd46e524d7c34984bcb08ec18b608fe7874796de3d9ee994503b1e358b43aa3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "263483fb345e64ec6dea8b27376c39f2b844936e781171792f54955bc87ba395"
    sha256 cellar: :any_skip_relocation, ventura:       "c12169637deaa1dfc117132d5a03fe336c400a15c4c03d7cf73cf87c9d80d93a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e97447bc2d3474ca0a73f8759898a7681d53640af77f855d868e5db6a8a93b91"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
