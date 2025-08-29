# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT84 < AbstractPhpExtension
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
    rebuild 5
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "91695148acfff44cfda38c28cead476d876c2c43d801f9bc69adfc8ac3018578"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e481ef807493e64e42d83c447dbe5004061715dd26579cc19d5e5a3570148ff5"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0942f889a48d252f4bad6c7cecc06132f0053bded56e63239f4b513467636fb7"
    sha256 cellar: :any_skip_relocation, ventura:       "8a9fd239ab32345e3c3e0fcd5458d83db13305f1f4c2aeb3c12d8e4c9c532040"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0d6f279f13b5193652c6af1f790bf872e887e0cc87bddbeeae38a6e77e9d6673"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65b605ca0293d88f0a52be31f157d57bf8f93c9b890289828fa40f09d525573a"
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
