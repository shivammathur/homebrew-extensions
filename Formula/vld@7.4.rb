# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT74 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.19.0.tar.gz"
  sha256 "4f591dc042540d1d6a7cf3438e4e70d001c2b981acd51b87ab87a286f26e282d"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "572b2ad2978c2c55c2b01319295486630a2c0fb9b96a33b41609ebe2ed7d91d8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "933479e7b1d7eee36b9ad4bed0d28894167a5c6c2eb017019bcfc3df39ff1f6f"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a200de63fb749cb9c7409e286d0666f60f18443c978b6231b7f0316c103fcafc"
    sha256 cellar: :any_skip_relocation, ventura:       "1a4830beecbb690a95a40c674b5a8c1a365fc8c284e17c234de5a8d0943e17ad"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2ba50cb508a91127272056e11ee46d6872fdc21c86e97dd788b39111e4bd5e1b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "35b7a774dbce07068deea118185bd019e000d8cd586f574b772a48830817629a"
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
