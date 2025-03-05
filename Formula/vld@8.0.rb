# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vld Extension
class VldAT80 < AbstractPhpExtension
  init
  desc "Vld PHP extension"
  homepage "https://github.com/derickr/vld"
  url "https://github.com/derickr/vld/archive/0.18.0.tar.gz"
  sha256 "b6cd6165014bd8c1ddd8b473fc2e232a722c88226a52368c32555cc9cbfa71ed"
  head "https://github.com/derickr/vld.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "cda5ecd7e6f4d33ef6f249c6aa8e70399b818673c4c6241672616d1ad462b110"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "116cb205edb21f9da809a7e8beb9d24c0a84657bc7f9591d323eba8bd9698f79"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "80ed42bad515e393a2b370ead1cb510c3a59e6f51af6babd6ba460d41ac09fad"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "70e835a4103dd49fc1e00038b9b39baa3331ba70c3b62d7eb0c96deafcfffc74"
    sha256 cellar: :any_skip_relocation, ventura:        "801a2829aff17fa0f7701ab3a72e42b12468985a789d8e6546355c5df0cca11b"
    sha256 cellar: :any_skip_relocation, monterey:       "1e9176579d93a2711bc350e9fa218ee544b37e419ded6caace305c7e4c7d1c38"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0c4981892b7e4398496e3321fb894fbf056d1bcae3fc1617b552a442ee1ccf4d"
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
