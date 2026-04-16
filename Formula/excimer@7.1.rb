# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT71 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3b0aab9d26bbc27495f49e0791f854a6a5dce788d0eec40a943d3212221e2912"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0f1bd19d033dd262caca78b5394e3583b3d076e16ceb404f4bf4a3c9165976c4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c0cc408c626f78377abea4f6373e2f07309d7035e9aba025a6d47a5f3caae6f9"
    sha256 cellar: :any_skip_relocation, sonoma:        "90b1f2b4f5860825d10df5e25524bfc043893611b38e5ab9c45c5510911a66e0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "10ecf13624292fdee77ae582d96a826879022ab75ce7fc4938d47d4b2fcb2ea0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "703f4d397bc5469bec621a1bb3661260493fb494de1dd4dbf8b7c5ed7e0c96a3"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
