# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/ece1eee8bfab5a883fcbd1596a5d6d26e9c88579.tar.gz"
  sha256 "df994e95a41b3a1f0866995da3e0eb1dcee5a7468aa979ba4db509a5d3637b8d"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256                               arm64_tahoe:   "81dabb4235a0359999f0df98abebd02672ec1c53c5a5dfc0f01a101aa5424086"
    sha256                               arm64_sequoia: "4a7a68d773ae3814b2ed26aaba25af309bd4fc777e680087ec4e0b567269468f"
    sha256                               arm64_sonoma:  "57992cf5317fcbd3e84fb6de1e0d8ca5e8e4226771abf7578d179e6b2d92a6ff"
    sha256 cellar: :any_skip_relocation, sonoma:        "5fc5fd43361648950ecbbb5c753bffd0c70eb3d9b3865f41d0f1f2c166976092"
    sha256                               arm64_linux:   "83264e2334fdabd8981ca27f58a5edc2a18ca8035dba269db4bfb393b4c269c5"
    sha256                               x86_64_linux:  "5cbceb5cd5be2f121dd4c06fa0e2a07be086b24a469d4d5ee364f3823a7e5bbd"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
