# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "c3c9ddb936d094a64b49365a4a2aacb28f0a288b3872557d4f9cee9bfea6914c"
    sha256 cellar: :any,                 arm64_sequoia: "a000f475f1645d7fb76aaee0d518c03d56359c344a80e27ebe26b75bf720a07b"
    sha256 cellar: :any,                 arm64_sonoma:  "a6a42fec510bf4611277f89938c7540a415132d6b8e0b896669ca2e38ca295fb"
    sha256 cellar: :any,                 sonoma:        "d4a2397f85f2d28b09115d35ecfe0b6889c9924874ead35cebc4eb33f182b7cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e486b3b2a35a611b3909fe764153e05c43a84bd46b3ed50cbaf4c3e2195103ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "301a15c3e7a1af29b33e409b46d1fc7b1ad64c7b43a605e6c4511659fb352c55"
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
