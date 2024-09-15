# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT83 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "377b205bb64df6a37e338947eae08519b0f5f5e3a82f19a56c09f52b3efd59a2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "46ce0e6c718762f0b834e281a90c16efb539b5f8fb06e14818dafd1a633517be"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c12532ecf08fb59139886d89999543ecb72b5a28a177f903c6863e7e2d80c72a"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "af403a9d642d0a4e19d9fe516adb4b390c3d29b86f63692d6b4badb7500f2726"
    sha256 cellar: :any_skip_relocation, ventura:        "5cd9dd99a5c835ca02fbe9bb7680912e6fd51ba28451c7b3e3eaaadc974a2614"
    sha256 cellar: :any_skip_relocation, monterey:       "104451dcf7a993c8db307966b9351523d47b9add9746f33152c208d3e8fa1d7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "42dddd40000431af0911a7d160b4b7e6649636c0bdba5619ea2525cb9edb7adc"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
