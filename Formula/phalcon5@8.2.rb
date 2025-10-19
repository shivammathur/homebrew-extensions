# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c43cab0a6fedc34b112fd5daf6124f07eda33ba0ff70b9d6dece6b2f86dd589e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5b707eeb90335335ee4dc7bdf2a281454668bebb8ab0e0b8ce7c1c4807e8944a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0c9f62ebce4d55faaf28974b02b17e8302eb8eceec3b4e8a3c99d2b61a6b549b"
    sha256 cellar: :any_skip_relocation, sonoma:        "6ea0b27faa92795192eeea9d844a5ba877a9b96e656187a337ab54c7fcb237df"
    sha256 cellar: :any_skip_relocation, ventura:       "8abc789646d8440994550eabc875fd640ea36b62a57257208e1ed97bea4ad2a8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "14dbc980d14fbab0d468a494995c143145439e17e4f57778ba8238cd78c48925"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ffe0790d22e5839f08f748af68c818c78f823b72afc10d7502b3fe2b47d2277d"
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
