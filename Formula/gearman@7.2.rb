# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT72 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "326481b28e424ee3c2de3ce8be6409df1cddbc378b4c58f939b87ddef60ea681"
    sha256 cellar: :any,                 arm64_sonoma:  "59e1f0547094153b012502e51bf323103069c9318183dfb1d677de66db80a07d"
    sha256 cellar: :any,                 arm64_ventura: "f3d66a8e5c119ff82dd1e33f7a12f73a94bda178c684e83f98458eb459fed8fd"
    sha256 cellar: :any,                 ventura:       "b623ab89c3d2b51cbcc3f6b331dc82405d0750ab6489a8a0e689b8765078d333"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7bea01f040fe5e0ca6f03f888dcb96fd3494d9208fb5ba9741b47a68404a3bea"
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
