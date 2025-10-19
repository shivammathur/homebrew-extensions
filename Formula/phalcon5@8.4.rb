# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.3.tgz"
  sha256 "2b1983f09b56fc2779509a8ac1df776c368782538a7ef6601c0d4aef9892fe83"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5923e3e7c418873590b5a256772b61424a085d9a4cd98681208dd5d6e4109cf7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cec83812e5b6962f4ff460a2065bfaf956a5e7af7b9df92a6af99ec53c931d04"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f53d6e5d13b4bcf005969fa83c79956bb38dba5ed8e9a6dcdb0d90e7d2d93f0f"
    sha256 cellar: :any_skip_relocation, sonoma:        "ff02f719841a2712897b7286d2c11e9e30ac399c5468f530ac4185ce0f6bcd99"
    sha256 cellar: :any_skip_relocation, ventura:       "7c0cc5a301ba7a90aa264f7c3245d12c303952ac845c5d8f40105af9f874fbfe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "edc84a5f7bf122dd4ba9ace8c9594788f3429d15748dbe9107ef29b01599f2d8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "495ed2ff2fb6c53073a6660131d88c06262ba8bb816c88f1680eeb044fb0bd90"
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
