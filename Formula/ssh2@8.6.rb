# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT86 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "727cc9cdcd781f3ca79ddd807d04dc2d1bb9e3c1755290a94055b455b93110dd"
    sha256 cellar: :any,                 arm64_sonoma:  "15cfa52dab69cd1b912d0d61e27e5b57e7f9ef01a284285e01d18d7c9ed99b58"
    sha256 cellar: :any,                 arm64_ventura: "326ddcccd5810d572df4b036d07bb6456a69a8a9fee2b48b9e45c0527ba0af71"
    sha256 cellar: :any,                 ventura:       "7ab4f7fa05f21cb6ee9e65e01c07159f6e06081ef44d9d9e62827ea1741e4730"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "2d219813086a2237ad8af316cf4597b916f2cc71427722f1beeeb4be4a356f9e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e02ea99c1a5799ffd78f83fa4464e0e30265483f614ebe51aff81a358966e818"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
