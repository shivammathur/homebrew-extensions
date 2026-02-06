# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f9fc2d8c90fe4d112a053f3b3755ec2b233362dcb519464e1093b90558fc8f39"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "955afec17ba26ac6165a9d7fabb7055be9be54978942ed77bb7374fb27567395"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d8f959a02f2c2926697f8822ab58a4aa586f50f08b190c819a1aae11bbe205b2"
    sha256 cellar: :any_skip_relocation, sonoma:        "3edcec5961b9823f384b1e6bb9790e9283e3cd410f8397ebbe7115ebcb903caf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "481c086cdca207fc8fcae9ea6fd56cb7d27b6acdb7f6d9b5ab082e0e39869242"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f0f8d0425b4057f623acd7f104173e8a856eca296edb9156fdeea039075f3b32"
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
