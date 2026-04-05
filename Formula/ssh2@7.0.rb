# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "188031ba45d87be97bfd8b32c10230b1c0daedcdd022345cb3121ed3df30af6c"
    sha256 cellar: :any,                 arm64_sequoia: "93ac13e75b9b6934579e1a2bda8b46bf65995b8420b84bbc6293d63c444da935"
    sha256 cellar: :any,                 arm64_sonoma:  "66fa143be784bfdf15afe7f570b92fe6f434471b892e33b087fbd5a505256614"
    sha256 cellar: :any,                 sonoma:        "cdcc73db2990649fb86d40cd25130eea113d542f1d45033fa007b2c7e6101aad"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1a3b4df2f24e89d61f7ae3c59695861ac908f8f10cfb4f6a85012703df40bf4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7dfd5b5a53425771ea2c2f6485c5d341a688f45be708921326e630acdb589975"
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
