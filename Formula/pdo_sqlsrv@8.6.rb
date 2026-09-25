# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  revision 1
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "1cef6ce492e7cc9fc35eb5b0a5c8bf98c0f349b0cd63fb3f1bf5f4c9e0cf47f8"
    sha256 cellar: :any, arm64_tahoe:       "44d13bcde1427d5e3d9de7a678afeeca878a98b0a15c8b7f3b4537a0a693f9fd"
    sha256 cellar: :any, arm64_sequoia:     "e976c8ead9dca60f33dafb2ef6a27e041477e79a8e7f9d7d49bfd5c733e1da4c"
    sha256 cellar: :any, arm64_linux:       "b602bea74c1ce2542a0346661a4c78d2642393d6465712d9b11e9df695a769bb"
    sha256 cellar: :any, x86_64_linux:      "859a656b9593a997b26945bc9a108a7340be139e4bbc05aeb94a0e1d05ac1edd"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    inreplace "shared/core_stream.cpp" do |s|
      s.gsub! "php_stream_context* STREAMS_DC", "php_stream_context* context STREAMS_DC"
      s.gsub! "php_stream_wrapper_log_error(wrapper, options,",
              "php_stream_wrapper_log_warn(wrapper, context, options, InvalidParam,"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
