# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT71 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git", branch: "master"
  license "BSD-2-Clause"
  revision 1

  livecheck do
    url "https://pecl.php.net/rest/r/propro/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "ab5b8a4b7299d98b1e382a7084cd3d173cbf50fce6ebd2071af9a7d3864643b1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3ac2032110d5aadf3a3de294cc01d445cca5e47b2514bab86e6268515d7e064e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4726a2b7ea30a9c2fa0e3a6fcdd9a74e0ac3996a9cdeb442962624d205e8e250"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8ff982fd0ab94a9b95b45a65ea80622e28861209608826aa125a6cad94a8032e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a0ff5d394daef1d1ef8f23fd28b6516d727df7315870ff4c70728eadb4843e2d"
    sha256 cellar: :any_skip_relocation, sonoma:         "453878ed8e9a295195639572cc0c867cbb969088d7d4a9af34d7b4b9cb1800d0"
    sha256 cellar: :any_skip_relocation, ventura:        "41018aa75dba4df412d7d4d4b3882bb01e8704b3f602db5162bc91bd69c00d1a"
    sha256 cellar: :any_skip_relocation, monterey:       "4f89ce6b63f814f58d1ea2857586c269cc066d4c53a0d97ecbbf242e67febc57"
    sha256 cellar: :any_skip_relocation, big_sur:        "dce45e1df710d4ddd7fef47e99493ee93d32307e4cc3401dcb99d07d7d90dc28"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "06408529774bda9ed836e075bad1fe936dc199b79c4eb0e8420c97f33567e30c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "23729e6f95aeb578d0adea2524e33e5c31165ca7a907e2569a76d0ec96a77413"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
