# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT83 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "2bd64d6acadb3795129164a97d19e475e22cd4db036cf7eb5448ad4dd1102b94"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "104eb44be267c90d722f0a7f74d57aab166f3d84b5929ba731e0d134240e9be5"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "54b1704ed4effc44e32deaee65c001ec83724ae6461cbd278af8e19489d0e439"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2ad0af1852211d3eedf8bac67c22a788070db9fc346aea6a464d5f278eedb541"
    sha256 cellar: :any_skip_relocation, ventura:        "cd9a0c5a75670ed80ede95d6c174b98664f9dcdb7b2f83e673a92fdf22d9e340"
    sha256 cellar: :any_skip_relocation, monterey:       "bd86d1cb217df4c6d41c42e1bd2c2e907ac51905e565c52bb61bd226cf18d7df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4277294ab5905fbb5d79176dc6731c1785f0db1faee3589d8cc568162ec524e5"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-vld"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
