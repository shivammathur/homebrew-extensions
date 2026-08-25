# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.1.tgz"
  sha256 "d10b650444dfa855370ae4c51d1e319270432322a1b413cbbd0b728d0c150b4e"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9470a7944c6af9d781f16d6ee9794c249946d804f9245b2db36c4935fbd8bbbf"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fd6d4e1f49f68aeb6cf3980a388839951fa02b6814b1c7828d890fcf7cd25957"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "921ad51ab2dac080820a056fca83baf123fbafa5240af718167779bdfdc68bdc"
    sha256 cellar: :any_skip_relocation, sonoma:        "5bdc720501fba92b402cd5df9d9903891ff27dcd42ff6b0e9b99e5f56ca62f90"
    sha256 cellar: :any,                 arm64_linux:   "f6fa45bff486d5121f92d19554bd00c36449a4223ea3d9a6cc627c38adca4444"
    sha256 cellar: :any,                 x86_64_linux:  "a597b8cff122900c4a71cd65928ea23a4f4ce29cf9a7da736eafa6c399a28bca"
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
