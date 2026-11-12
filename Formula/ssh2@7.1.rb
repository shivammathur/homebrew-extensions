# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_golden_gate: "8865d55789405e7f4b8b82f1c4c9651e5562f6c212ae15dad727b1710a3ddab8"
    sha256 cellar: :any, arm64_tahoe:       "d8979043077b37c17aabfe056da1e058750d96087018cec9595e19c2204500b3"
    sha256 cellar: :any, arm64_sequoia:     "fd3b85e9e5eb6ca4d15691bc2772b773f5d1034046d656921099c456de4abcbc"
    sha256 cellar: :any, arm64_linux:       "cb08cd40faec273b77e2f8d12b07411fb0d46074f977fbe214d718cb7fdc02f7"
    sha256 cellar: :any, x86_64_linux:      "a3b53b1a01d9bc1ef09969ade12e1925a826e37a652df28d5dfcd20f81f76510"
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
