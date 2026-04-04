# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.0.tgz"
  sha256 "c4d0e1659d82151ce8f0087ad9f2dfb7b0bd8bd19814526d424d010e24877601"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6041141d847fccab1a2970090bd4c2c9c3c0da259cc9d967bd31fd94ed326e06"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8f0ea1c75406df73a39e645de9715fbdee6448b16645b4e5d5bc0149afdd2435"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0fca07c99d9e9fc3be8fc1d9a87209a9dec6d007a63e0188ec2a40f02927e116"
    sha256 cellar: :any_skip_relocation, sonoma:        "9aedb85eca8107539bbb2d72973448591c4b602f65584de510cc08d9b075c348"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "27f0aa81adc4d889910854ecf9e077496c665e47623046f0bd9b9398ef6b0f1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2e1833aec68d5f1dc8ae0f1ec05d1808173eed7d3d2e8b83fb7774f75a3b176"
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
