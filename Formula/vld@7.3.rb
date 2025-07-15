# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT73 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.1.tar.gz"
  sha256 "bfaf2ba7bdb11663bd9364096daa246fa4bfb1dec1eed9fa53ed9a8d5ed1f647"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1e8d9f2c9fb77c10d60cc49825ec02993f8b63b60a21e2458beda1a684197315"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0c7d272e3c03b4f92f7e0bf7c5d61e6a24ce6c28fb43f5e84008f0b763c3dad4"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cc24b3e673bc9d1781277d934b2e0e8efb198e2ecd7a9ddfbbe584028a214ce6"
    sha256 cellar: :any_skip_relocation, ventura:       "7e6d065d64f56c590cba64bd63f08553b33bb70499b09dc4ab65cb4476d8aad1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9bff5536e34e939ae92cf5336807aed154a2c7a0dd928e5ead806cadbe84ce72"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a160dfbb544d02959d9105c35e9435f8a4a6b031da014168a4506010423e13bb"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
