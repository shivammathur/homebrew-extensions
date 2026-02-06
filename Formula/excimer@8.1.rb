# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT81 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5cdf5a2a7f66d535a0c9ce69222edbda7eb2f93e8beb3448120bfa46e25a8285"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6d55beaca1e7e88016393d1f3e5866c957115b9ecb095f28871a8427c5d2badc"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3125a0fc31a7726e2127150adccca8a8ccb883e2ab114be180bf1bfd3215d058"
    sha256 cellar: :any_skip_relocation, sonoma:        "61dc4bfdbd0aa215f53f3b31f84ae7f75702f27edcd4c410337ba1b166a10bba"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3b4ee7b495e5a3f37890a583e98629e5a8aa697bb793e93fa1bdfa0b4de21f78"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f062d9cca2f776b567aad9e47dd67c41fb32bf6617bbd110f88d2928929db2b9"
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
