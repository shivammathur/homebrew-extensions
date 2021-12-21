# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhpExtension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.11.tar.gz"
  sha256 "2ca64444a8f02401e60637b2ab579b952a542e4193c5a47f4bd593c348fb4aad"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "0c34185b80aabbdbc49576c275fd5f94a78b072fa643e8544be264e0b0a91bdd"
    sha256 cellar: :any_skip_relocation, big_sur:       "6b6b3dea756f92d493e66eb1fcbf114bc4fc07d1e23e6d3d9599c03e3bed8eee"
    sha256 cellar: :any_skip_relocation, catalina:      "98f96dc67d568eded95a07d3ffe42ac89d21f778e2bd4d512c4fe77c57d51a2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d52d62f60683e39fedcacfb79b719e24a021c01cdd32b3ae958a72522b3441ad"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
