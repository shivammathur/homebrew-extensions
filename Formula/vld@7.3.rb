# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT73 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "4b4272940c227c8819764cd035fec4bb61b71deef8d031e76dd877a9867ad02c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "9c8168b0a9bb36bc7f015f11e8a91d47a6af623ddbf6b6e38b9c1e97480bd4bd"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e9e658d6f2128aeabfc497ad717b28c25fe2d074d7ba0e313f2733d3b9949ce6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0fa0de035399e93c97cf843a1df81fa740eae5a0b0d6280267ec4fd52f30a735"
    sha256 cellar: :any_skip_relocation, ventura:        "287707fcf2c8a62d4c1a1687ae7b9bc498ff9969bb0043283fca93a31015895c"
    sha256 cellar: :any_skip_relocation, monterey:       "5a2327e34266d7cdbaee3a79716b382f1970ba742e4b37e0c5c1fdddf824faa2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5a93e4fb16d6f388eed7625ff59b6226b05e8f577f61fd9a58d47952613e318"
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
