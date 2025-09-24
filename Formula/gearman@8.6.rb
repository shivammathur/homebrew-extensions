# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT86 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "8ff3539277c34773b434100493c70ae73f8785311885ee45f7e75dea1432220b"
    sha256 cellar: :any,                 arm64_sequoia: "983687540d1e630770f57815ae87a7c4807c3c0441731deb3cab57fa5f10eba1"
    sha256 cellar: :any,                 arm64_sonoma:  "84e502ec399264eb77d2d5f77720b515e92a9b385d866270408e163e66293c7c"
    sha256 cellar: :any,                 sonoma:        "b8219b60d23eaf4c0e6e63157d95ba09394ed3afff7a156898690f9137022204"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4aef5e397806c54c606a9c10dde096357e89f7b50b368276d19f8de157411150"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "82686afebec15946fbffa24fa61af1bbef47f20e1464be0dc97d53d5b4fb5be1"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    inreplace "php_gearman.c", "zend_exception_get_default()", "zend_ce_exception"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
