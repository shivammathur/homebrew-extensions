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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "77024437e9b42bb6301668b638fc02bc670b8e47707b42e057ebf14c736e295f"
    sha256 cellar: :any,                 arm64_sonoma:   "c153fd9dec286ace354d10078c038bfdfc2fb087cb2802a90052eb0d4760acbe"
    sha256 cellar: :any,                 arm64_ventura:  "9f154998c6f28908254348d29a16b6969e5eacd489023a6e94fc4f03a09d9e2d"
    sha256 cellar: :any,                 arm64_monterey: "cf6016c8e804f574d7c344478f3d8057b9541ff6533faf9c39fd7ed45555a147"
    sha256 cellar: :any,                 ventura:        "f5dc9e00c4921c1370bb1724bd27cc18257e8bb14b03e8eb17050e828b9ee058"
    sha256 cellar: :any,                 monterey:       "6f4a3b78cd972fa39aa1db16c7c00a0f0c856cc51f8a6cee45291bf4d2bb1bd6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c253e10522fc43f758722d1f416c441c0c00f84a75ee6cd8742cb84926edf987"
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
