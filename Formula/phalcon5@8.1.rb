# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.22.1.tgz"
  sha256 "328bc4998d56f287dfc8ada9e57725fc2b2fa2ec5f56545461a60af9d7905167"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d627ceec8b4fce90021d8150423120697aa1daaa61ab8c2b8788cba09a291d20"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "5ccfebdd6736e5af3e8f6146536815097f0ddd16f41b87c09ce690035af764c5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "3f49a3209d38c969086575597975c129582672a17b79b4ac0046c07a4002c627"
    sha256 cellar: :any,                 arm64_linux:       "de26ae9141a1951aabf11b5339d6b1ad43964c63a78176df0b1496a6dde81d7e"
    sha256 cellar: :any,                 x86_64_linux:      "e5bd05bbd174352943f9e35b425234673c57c657a729a14d4dbe303a48dff90a"
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
