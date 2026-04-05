# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT71 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "33c48d9e5d96c804208b291da0606be2b5bde5eda5e6efbec0951597577793cb"
    sha256 cellar: :any,                 arm64_sequoia: "d130a3356bc80b143c9b516e2c3510ba2836b12696e5254018465f82d6073c51"
    sha256 cellar: :any,                 arm64_sonoma:  "1cc2c9f5dfdc428418bb1447c11722870b669fc972fafde459aedc49e2e3a3d6"
    sha256 cellar: :any,                 sonoma:        "311154c289c39c9f962c496c3c28085482c9815100877fe45448a247d2879d47"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f65c9e308151970cc65b84827eacd3c88ba57ee3f005dbec9ef00f6400c668df"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46fd6caf29aa5e6c5b6d7b3373b7a29d11ac37b66b4c042a06b014113be2c978"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2_fopen_wrappers.c",
              "const char *path_in_original = strstr(path, ZSTR_VAL(resource->path));",
              "const char *path_in_original = strstr(path, SSH2_URL_STR(resource->path));"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
