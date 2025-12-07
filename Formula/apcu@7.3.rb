# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f80d2fad678479d858f6d1f68923f84b3a1cf8e95ecba5bdd9c11a1630e78435"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "88458b1900b07b22b57c8ec10292f7b801f166e0331172292de035c4c5f0351b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6364eb7e56a4023ac98f1055bebc252e3d50d9027790ed41a4cd8ffafece0779"
    sha256 cellar: :any_skip_relocation, sonoma:        "d3a2b0c04c6faf2f6895b7d189d5a09de07cd5d6399e82c77a454ecf2f17bfe1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "023bdc2e58154115576607ef880a93f0386aa6302d3b80f65c6f78de0680e163"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "858547ec16a0acb49bb78e12a7838103029871af8b6c857a401425070098895f"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
