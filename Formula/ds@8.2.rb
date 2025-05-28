# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT82 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6d9ee6b5963f5b941f7681a5672c18c5188b30cde21b567db31d4e6f7ae4cb7d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3de9ce28d5cdc860d30a800787209439517539f5974bba56fba6e94e29ec6d0e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a24cf95822301a1cdf3de4e6be4e5bce507973d9573fe18605dc9443f30e1159"
    sha256 cellar: :any_skip_relocation, ventura:       "7c25edcc207f76e7e813787ab1765b85baaf824f57e50256cd754f6bdc571ebc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b9aed9c698774178b2d953f4b7dd3c3541a5081f69891db88aa303bda83d07e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7244bce8d150614390ad29d551e5694841cf48849f37bb6d9031b7fce3cfb809"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
