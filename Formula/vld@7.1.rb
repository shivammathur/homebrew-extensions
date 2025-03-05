# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT71 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b4a3ad80baf9c9df9859fb632708b31697679606d5744d1eeec69087e474d24f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "28d3a0021c9245aed1400f970d4796734c56fd5e9959abfd4fa154909f7b5170"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c28dc2f6cabfe194c052018b0d1a7cf1870787d3d7500fe441592026df63ab33"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "82115d41ad6aaa2a74f1b5aadc71f13bea844fe9f2c91387521ade461633e1cb"
    sha256 cellar: :any_skip_relocation, ventura:        "d251c534bba097ee36403a20173ea9f8c2554f166921d939cc6820a9a6f3f1dd"
    sha256 cellar: :any_skip_relocation, monterey:       "85e19688d255e1d2e94f235b9947b28495e58f280c874de0661d931279813cff"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7db25e875a4b9f2bb63fe86f8a82d2898b0e066f24506a4b68091048f8c2efba"
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
