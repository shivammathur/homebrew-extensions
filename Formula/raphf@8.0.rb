# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT80 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c81b2a93ee33755b1d4c5954e0ac5e410469d2714e406d1dff09d1960a51bb59"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f87d7b781c6eefd011fc7c89c8a24d1f11e3a6ef8d03c7ef00d34437409a6dde"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "208d21d6c2301cf9932229b35691a45069b8fc9a67066c542ad428c5fce0db0d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "538cf877b8ed78dcd6184d076b80f0cecbdf8ebe8ff3922f953f832690458dab"
    sha256 cellar: :any_skip_relocation, sonoma:        "0722c1c6f19577d03e9b87464cd74cf0b19233bfa06a75aafd161113227244a1"
    sha256 cellar: :any_skip_relocation, ventura:       "1bf75eb05a99345b6efd9458f130151cadaa978aca780dc062186ce309e5a97c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1696cf8b67697f0b9bb839ee03554ae37b8325b52e951b6a3a1d13e676c678d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa5e9df7c504fbc9afc3b8a3f698a64c18507b9bc586e3edd99252e938d052fd"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
