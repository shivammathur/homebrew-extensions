# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.1.tgz"
  sha256 "8331f47cf760dbaf13ae2d77d63971005b03df40279dec97ede4b537d14c9591"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "533ba324e050beae3be6b89bd5f0a3b9ec14a8a62a9002f6e24d9059e14f2f0b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7dc73862ee3023571780f4a17837062e1ce01717364d0b1ea6aa2d0165ba3040"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f14e462b9ff25e884c06cbfa3e6a46e8613473d3973df88a8375f3ddba3a29e3"
    sha256 cellar: :any_skip_relocation, sonoma:        "211417f135ac08b47614740e5a3a4882d7cc05f8839100a2b827ce3a4bc0fc27"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6e17aebad2944fb919e41eea35efe2711de1ea02e95156aa26a4f1c79f85b5ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "280a8bda560b96edba68706eefe6c1fe04bb984aa156c87f70f64834ba0336d8"
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
