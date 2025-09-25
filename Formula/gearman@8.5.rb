# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT85 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  revision 1
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "be5ea0480a7862c5b5cd9575a7af4a5c215ca91882c0c014b9742dccb2496b94"
    sha256 cellar: :any,                 arm64_sequoia: "ffd092441320475319bb503b4e86690791fd77d6bbb922ade3f2aedb2fa99597"
    sha256 cellar: :any,                 arm64_sonoma:  "a1e8e00e5a425fda765695c32fa26554a42382b83b1eb29ede5b0a48e77859d8"
    sha256 cellar: :any,                 sonoma:        "a74e35b1fe59f170ac6010cd7c8c29ad0f1f679b179a541abf265ec69cafaa23"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "33b809e8dcc116b7959e3ad86a7661f9efe23435674faccaa5da0f54507db750"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "addcd54d57ce91fe771ffdd362e63cf99fa3e30ca1ab41b670ce135a5ac11c1a"
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
