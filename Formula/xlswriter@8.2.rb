# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f9add9cadf4cd2d1ea40b4e35aaeee6e193d01adfeacd958fb3276276e3ba2df"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e7c4af65a71502253111574cac515e41167a039b685042a5b54c81cf85ba9575"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5f437badfe80ffc3d67f5b2ffdc52afa93987e7ff84326d51c717861c230e682"
    sha256 cellar: :any_skip_relocation, sonoma:        "beea594612f1a1e5d0349ecf4aabbaac576dfbb16195197b1a159b567dee7632"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e10022ab0b3a6e06cd11f60c8ee28b0282b15de2a98718b4659bdd44c4bc99fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "194a157bdcc2b8c0d75a1fd949de8f2fd859109982e9e7ffb03bf925f27705ce"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
