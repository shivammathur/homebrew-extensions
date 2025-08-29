# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT74 < AbstractPhpExtension
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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "292e5871f32555d0abdf0b883acdc3b5cb39d8c6556a63265fd8b88c5b4e4b23"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "f72bff828c2289bcfb5715e645ecd1288eaf25fe7598948d439118396aca872f"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "392027a6f16fde95f2bcf0efa472d8f9cb9f20faf8c39c219cea285b2e33e006"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a857e4ea3ada7ea088a4e3fbd6e3fb549da9a1d2771144785d1b834f016e2e05"
    sha256 cellar: :any_skip_relocation, ventura:        "4c2fa494c022ae59fb3b43a93807bab30efba1fa8725fea5a6e36146a2358d6f"
    sha256 cellar: :any_skip_relocation, monterey:       "cdfc025fc393f635e73e52720f672f7dca2f3a68cb5b1cb4b7be3f09e4154c97"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "9b722b46f8d6d4ff2d25da57517c3ee5d0ea874af616cb70f54c9bb71a67087e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "56753b61cd4631bf340c78c9c34c5a92b00e5f3fd34d5161d791804115f9bb52"
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
