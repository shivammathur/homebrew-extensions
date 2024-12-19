# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Protobuf Extension
class ProtobufAT85 < AbstractPhpExtension
  init
  desc "Protobuf PHP extension"
  homepage "https://github.com/protocolbuffers/protobuf"
  url "https://pecl.php.net/get/protobuf-4.29.2.tgz"
  sha256 "535b89e3b4fa26cf3d74479aa9c63e5fd1fccfb9cad4e03ba2d7e97053bc1056"
  head "https://github.com/protocolbuffers/protobuf.git", branch: "main"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6bb28c97920efccd15bde92b7f5d1c1ac778cb4b477d7dd5fdb254a4315d9a82"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ce5338da5a0c5c4c82ae62e272986f89a7a8d898504fa08c701c883b7fe71f29"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "1393873deb1123f67c939fcd08014cbc56426904b8a9317a85f5840abd6ac196"
    sha256 cellar: :any_skip_relocation, ventura:       "4b19a33956203662b98cbed6120b08074ca0fe04fc572184cc94dc70fe6002fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "de56981b325159d8fe3440a7f942663caa68fcae61179cca223123ff64c6441a"
  end

  def install
    Dir.chdir "protobuf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-protobuf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end

  def caveats
    <<~EOS
      Copyright 2008 Google Inc.  All rights reserved.

      Redistribution and use in source and binary forms, with or without
      modification, are permitted provided that the following conditions are
      met:

          * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
          * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following disclaimer
      in the documentation and/or other materials provided with the
      distribution.
          * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived from
      this software without specific prior written permission.

      THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
      "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
      LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
      A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
      OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
      SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
      LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
      DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
      THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
      (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
      OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

      Code generated by the Protocol Buffer compiler is owned by the owner
      of the input file used when generating it.  This code is not
      standalone and requires a support library to be linked with it.  This
      support library is itself covered by the above license.

      To finish installing #{extension} for PHP #{php_version}:
        * #{config_filepath} was created,"
          do not forget to remove it upon extension removal."
        * Validate installation by running php -m
    EOS
  end
end
