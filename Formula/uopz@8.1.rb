# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT81 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "54eb46dfe6d9a0d2d7ac842cc0095ce12c2d8b82f631d0a8e8772d0bc71178da"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a56b9d7d63a031a5e199fd7941d578e36160b9ced9de162bb5ea334aca09969e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "12cc23561c5f7d45e718954e69047819baac70ee9c929a55a9d8f251029f3251"
    sha256 cellar: :any_skip_relocation, sonoma:        "cfbec56082fbcd81c8a29cbe40f457e577223a037d587a3889aa397ef5632371"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b8be96cda19713d1f9e80ea5a6569e91ddf558b65e30e0330eb6ee1607746556"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46f521738b7a26fc283a44fa8a4d197f49ed580f5eb3273cc53d4f2bd3fcf721"
  end

  priority "10"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
