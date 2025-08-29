# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d20c041211d4de71f91e725908f124e675c46e86c6826fb9cc7fe65ed285dd15"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8e8a7181f36a67393923a475735915f4e74383e2fd230307bcd8e6fa887f20a9"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1a8b793b29c5dac53f97186d4b17398646a9452ac2673847fc3b39c1b025fafb"
    sha256 cellar: :any_skip_relocation, ventura:       "8fd834f63890f10d16d92732cf6dc03a0ef3ebee539346ec37c2c4e57fc23af7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "760f8d6c6e4966d780ecbf2231f9bd4c4c7d908a4589b0a9d9431ecb0348f609"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f24a53dfd1cfb4bdec9aaaf98cef399dbc4e306c1405071f16685ec278128b2f"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
