# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.23.0.tgz"
  sha256 "34738f486ac6ade23b70c4b5b4d8292b5fda3b334ea119b6b35dbcfab24df50d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "b11040e5ba155f0b9053aab3b61a1fccf95b55bc37c28ca8027141dac9dc8cf1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "642b247a20687855d9cfc96b435cbf455465d5ff85a2452c0d416e851859168f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d138c77f92afaf7f179c0d1e1338f3d476c18cdeb8c5e5016b48aa0e795d8f6d"
    sha256 cellar: :any,                 arm64_linux:       "3aba1e50272cbe6515fc8d3bd817705dbc9a3e061ef214f145ecbd540617089c"
    sha256 cellar: :any,                 x86_64_linux:      "5cb3e059ee96634743df1220849fbf57194ad973ad7d7c8d5ce4e6d487c7d4a1"
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
