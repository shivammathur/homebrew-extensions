# typed: false
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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fcefb164b21d88f2c2fc7350eddd851a1aa2b1ae5c57be71feb9724bd49ccca2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6e7bc73be8a18e18d855281fc67d2ab8db5361e4d2f06018b60dcfcc56f2217c"
    sha256 cellar: :any_skip_relocation, monterey:       "4a804e9c217e5488ffa2decb10ec82c9bd6aef0f595821d1525c364523d43e60"
    sha256 cellar: :any_skip_relocation, big_sur:        "403d89a93f13bae8c79f1d8e98ed81db8772ff5f1c661011b9e994ad6761df75"
    sha256 cellar: :any_skip_relocation, catalina:       "fefffe1a3c81e838004deaeedd4d776e8323132aee0ed61aaeeba8646d727f94"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "023e9c6b42fd49b8587d242686d2a7014625ef520a3799bbe2f102c6f4bb1058"
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
