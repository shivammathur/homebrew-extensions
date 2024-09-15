# typed: true
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "60ec1a09642aea71a6a9970a3a3f87fdebbfc19c42b8a77dcd8a0bfc6b0d8f0d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0128b06a73873b1be2a2e56a4f37f58b550707dd794a1476d69216f32d979882"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1cd4554ee16d74208975373b12e3d8575309aba33bcf2f9989646b34b8b2b896"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0c34185b80aabbdbc49576c275fd5f94a78b072fa643e8544be264e0b0a91bdd"
    sha256 cellar: :any_skip_relocation, ventura:        "9d3f7fd4eb97a8a120dabe1a3e8ecf311a47453838f4ec37e4eef17a3dd287b8"
    sha256 cellar: :any_skip_relocation, big_sur:        "6b6b3dea756f92d493e66eb1fcbf114bc4fc07d1e23e6d3d9599c03e3bed8eee"
    sha256 cellar: :any_skip_relocation, catalina:       "98f96dc67d568eded95a07d3ffe42ac89d21f778e2bd4d512c4fe77c57d51a2b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d52d62f60683e39fedcacfb79b719e24a021c01cdd32b3ae958a72522b3441ad"
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
