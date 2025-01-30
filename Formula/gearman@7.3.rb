# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT73 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "71842b09903ec6f0257c024ff79322d945e632c600bb45842a5a6779df19366c"
    sha256 cellar: :any,                 arm64_sonoma:   "9c4ae7e3179088325515d0e9e405fdf0e0760625d8ab897df3e2dcbef427f7d2"
    sha256 cellar: :any,                 arm64_ventura:  "ca33b0f2f9e64a8e6ae2fc3fdbbcef97ac27f36602cf6c9e8550e8aa83a3c978"
    sha256 cellar: :any,                 arm64_monterey: "ef70ab535917adf9000cf4d12746a479a9b2f2a59129d1415d848165eee88501"
    sha256 cellar: :any,                 ventura:        "2f3d7462ee9fc9c8311ead394f854f3239b11eed98542e38bab12962539d73d4"
    sha256 cellar: :any,                 monterey:       "46a55d3fb243ab12b03b0f82197801fb997fb0a379dcb256c46d92de563243f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1981396ae56f2ccd39ab3562f4cdc4e1b43f8d1ad0559a25fed0cef37ce3ccc3"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
