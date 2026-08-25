# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.1.tgz"
  sha256 "d10b650444dfa855370ae4c51d1e319270432322a1b413cbbd0b728d0c150b4e"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6d3271d3f7fbd8df221b109d17b35c8a3e562ebcc854b572d238bce30761746d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "adc91452a2a4ba0f6b67817521e9c1a85617346189ec2c1a75d9c379bf9678b0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d9a4329d4d5e3b2290044840e4d21280e602a77031dd5f6957dc7a0a2d67a698"
    sha256 cellar: :any_skip_relocation, sonoma:        "10bb487ca1dcc85cfdf613d38aca48dc208e3e1eed94ed3312a0b5eec446b62c"
    sha256 cellar: :any,                 arm64_linux:   "a6e3458d19021646354fb81f21cb72a01ddf15e2ca3eec612d3da34c78e1af1a"
    sha256 cellar: :any,                 x86_64_linux:  "16c852bbe14f006d7b73074bc9f385e3ba87dec2de87d9921151a75f5905896e"
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
