# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT83 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "3d732609435b9781d3cdd3c5138a2dad04b3d5cd0d9938870d37253f9706a4c2"
    sha256 cellar: :any,                 arm64_sonoma:   "ac4dd374468289e3be4d655e3a2e78c6ca31d3e01958ddb25ea0c3410b6cdc02"
    sha256 cellar: :any,                 arm64_ventura:  "e7a29d97c7f4bf292e5cf227ef445192ac80b0580bcb393e74f83e50533bb3bd"
    sha256 cellar: :any,                 arm64_monterey: "76f87ab33abf78a8798a8317e764bf0918b2a9fabe97970fe56a00e2e0ab2618"
    sha256 cellar: :any,                 ventura:        "d1878dfd694fe804c06846599b36013aca8eaea2acf877dca7c3fb9daee98b13"
    sha256 cellar: :any,                 monterey:       "3f436e2e4e285adbecb58623227414f9b239d9c0a8c9ab459f709f8f42b6eae9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bf6c8a24f81d09feb3148e8a8b0a1b5a08312b74cc4ddc49060f0c8bb15a7344"
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
