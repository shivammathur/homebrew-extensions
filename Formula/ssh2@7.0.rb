# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT70 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "d35837866821d4fae588c3ec2a04297f8116fdd4c2ffeb16ea176937140adc75"
    sha256 cellar: :any, arm64_tahoe:       "7a1052f7699dc060e7342e8920d8e2d66bc1fbc3923e23e0d6b1e355f6d76cae"
    sha256 cellar: :any, arm64_sequoia:     "82f1a55f683cb130354be15a87c962eeb94c7cdfb71beef3d98e52b5e4ecd9a2"
    sha256 cellar: :any, arm64_linux:       "e524a324bff06739c1b3272509b685dadc5dcaf7779847c5c7f3508b782314c3"
    sha256 cellar: :any, x86_64_linux:      "b7ea2f742715fef82e27b6b400797d21bd1500f6fa6a02f3ccdb49945b8bf7a2"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    inreplace "ssh2_fopen_wrappers.c" do |s|
      s.gsub! "ZSTR_VAL(resource->path)", "SSH2_URL_STR(resource->path)"
      s.gsub! "zend_string_release(resource->path);", "efree(resource->path);"
      s.gsub! "zend_string_init(path_in_original, strlen(path_in_original), 0)", "estrdup(path_in_original)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
