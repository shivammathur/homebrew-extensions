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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "818972c30572150ebfafae5b1154b75a6fe862c6473d74503e1624fae8ed59a5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "66aa09da14a9f46b63173e421dbbd6e0bb12e6c7f95d7584d8b76c0f982f79e2"
    sha256 cellar: :any_skip_relocation, monterey:       "4877b72e9000657eb86049af4a5788cbe06478cd487c6b56f7f7db20336b9e17"
    sha256 cellar: :any_skip_relocation, big_sur:        "81b10aafdadbd1fee74f2e2a1377eff23e65f2f0f534ce9d1af13c6c6f07bfa9"
    sha256 cellar: :any_skip_relocation, catalina:       "ed1947629a5b27532df31ea7010025c5566f842acabb7ccf8e30fd82ffa954f8"
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
