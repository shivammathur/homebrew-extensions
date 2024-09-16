# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT81 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "00df08ab1f2841c2f348dbabb5a77d68a49a91bb364f601773a483eec3800f8f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1f30953b62214d09c91e03670e90f2f1c318238245e390ae09e691a094cc67e7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e13a6d9dc51c80badb78e29a43a07eed29aedcf693a4b3713d6f7f0350237632"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9fc413abe794f149068f0de290e23f75753658525b19d664662b5dd49f0066a4"
    sha256 cellar: :any_skip_relocation, ventura:        "8f41595da284ce960e0cb6796d3efb3ffe13f8881979bb0342ebeaf7a5f8a849"
    sha256 cellar: :any_skip_relocation, monterey:       "ae4e4c202ba45d2fc1333ca6797c26efd4f7c39cbce1947a19436aafe5cb203f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3d43c535f6f9b73bb573058d9558d0f502f3396c74e150cc250d0f5e87828025"
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
