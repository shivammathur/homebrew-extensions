# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.10.0.tgz"
  sha256 "3b552ac17fae44512298f43ec47cd055679d40e8c74b782743021dce77859eb1"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "479768597dbe488e0b2cd7202df3dc83755479c8db7754b8f8843559a55e2623"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9b6428a9a3e0173486eeed1d1726294069043d4c4378cdee446fafa3df66eb37"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2b8e33193b091b383aff20b4d30f759addca9ce944901047d14a5ed1cc5bb662"
    sha256 cellar: :any_skip_relocation, sonoma:        "af65b89676bc1676a2d0a8724f442f4a324b0fc12da37a6e13b64d969736f9d7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "488a34b323f62a3ad40147293e6025c16c4c7abcd0cf09b849c4d5a1497df056"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4bb780c984d195b395010ccfc9a1f7f32725e4d57bae746b5f381dbe52c2d6a5"
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
