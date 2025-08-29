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
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "abbee69fdf034718718d5375728f894a2b85712496fac4edb164a682d0d860a0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "8af58e93867c5cdcfda33f1f903c41f39227840d9fe21956664a1f4bb7cc9fb9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2e07bdb06b7bf9bab7a6f2d5966f0e6e791fc0435895438f93ec03ca2c0986af"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c28c32e1b1dde7d49e8ecc653e46b8fa1ac218bf3364f8e441a97df67f6641a3"
    sha256 cellar: :any_skip_relocation, ventura:        "073bd8c0ba31e7c9455921ccbf71fca16d045673d6bbba9939e2c494e09d753e"
    sha256 cellar: :any_skip_relocation, monterey:       "6b52953eb758a646518d4b66cf571c179b14ccff5c440291a230f6586e974ac6"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "599730722f6102e2f03a65a79879c82ac68d50a4b6cf8f1acaa71d70d9bc3026"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "de338dea9e77408b004dac110600e03013b39b7a4adebf059356c143517cd332"
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
