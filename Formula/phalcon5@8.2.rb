# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d4ffe3e2c5ef963468a67c4900dfeca4ab11203321dba61f5d4496d8e94e8a18"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "277e95cb31dd41d60a90d393863cb534c79b99237c3e135ca713381861b2727f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "44d94ea787c423a237e4671331b0e0e408b368440530ac03dedc35ad16ae9856"
    sha256 cellar: :any_skip_relocation, sonoma:        "52b8754602be1d0d7015fa1bf4f6250b4184f98b03db54f8631bace87fd2e987"
    sha256 cellar: :any,                 arm64_linux:   "c8f3836d36f00daf38baf5004d429c2edf6427163caa4025b577925eb0073d8b"
    sha256 cellar: :any,                 x86_64_linux:  "0eafa2c8a14776b23d62642d61b2f1f1f52cfa6568880616453b16e08ae2ec8c"
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
