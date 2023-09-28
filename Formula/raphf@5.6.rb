# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT56 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-1.1.2.tgz"
  sha256 "d35a49672e72d0e03751385e0b8fed02aededcacc5e3ec27c98a5849720483a7"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b33b325d0965cfb1474d15b733a4e105d5a154dd4d19de580ead530c648edf01"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2a82636919842522bb4a319066bde7397c8c07d0ada080d5207abbb6daa13c69"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "818972c30572150ebfafae5b1154b75a6fe862c6473d74503e1624fae8ed59a5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "66aa09da14a9f46b63173e421dbbd6e0bb12e6c7f95d7584d8b76c0f982f79e2"
    sha256 cellar: :any_skip_relocation, ventura:        "a8272b55c7a47fe213b5cb12c4bb30e7ca805c8f45b0851c7a5b25c48de7699e"
    sha256 cellar: :any_skip_relocation, monterey:       "e292c4a01fa1294ab4735b14b698efd22862d931bfe27600d9f063aea273567d"
    sha256 cellar: :any_skip_relocation, big_sur:        "81b10aafdadbd1fee74f2e2a1377eff23e65f2f0f534ce9d1af13c6c6f07bfa9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1dc56de42112520d135f22da31017018b5f16c5402ab71f6ed0ae9a20ccf87b3"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
