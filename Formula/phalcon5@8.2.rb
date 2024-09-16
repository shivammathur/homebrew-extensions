# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.8.0.tgz"
  sha256 "d80b137763b790854c36555600a23b1aa054747efd0f29d8e1a0f0c5fa77f476"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "707f3fec1e96a6247b998eb32ed961e385e87434ac22dbb71882e1650ce99717"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "2c998523cae5af3f6254622eb5e82136893e34c88a7e686f0136bbe2198aed45"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e80bf1adf94c167675ff75062c8dabc0b0c89426aec190cfe0500384f8e8212f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "68ee74c1caf04110e20e1210f55957eba61c828bf57e7b64d621cc5cbab256e7"
    sha256 cellar: :any_skip_relocation, ventura:        "53e00db01f80dcb3687ee1fc638ce354daa4d3b079c61d66be44d26115a56d22"
    sha256 cellar: :any_skip_relocation, monterey:       "65c4aa18777175ee360f922b2cf582a49bf7522f7077c15629aa544f30053927"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0475193327177e897fced141984db271d78856a20e91c52a6b5615fea9a6edb3"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
